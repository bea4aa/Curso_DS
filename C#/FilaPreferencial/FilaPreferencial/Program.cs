using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Schema;

namespace FilaPreferencial
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Paciente[] fila = new Paciente[15];
            
            int numeropessoas = 0;
            string opcao = "1";

            while (opcao != "q")
            {
                Console.Clear();
                Console.WriteLine("\n----------Menu----------");
                Console.WriteLine("1 - Cadastrar paciente");
                Console.WriteLine("2 - Listar pacientes da fila");
                Console.WriteLine("3 - Atendimento");
                Console.WriteLine("4 - Alterar dados");
                Console.WriteLine("5 - Sair (Digite q)");
                Console.WriteLine("Digite sua opção:");
                opcao = Console.ReadLine();

                if (opcao == "1")
                {
                    if (numeropessoas > 15)
                    {
                        Console.WriteLine("Fila cheia, por favor aguarde");
                    }
                    else
                    {

                        Paciente novo = new Paciente();
                        novo.Cadastrar();
                        fila[numeropessoas] = novo;
                        numeropessoas ++;
                    }
                }

                if (opcao == "2")
                {
                    Console.Clear();
                    Console.WriteLine("----------Lista de pacientes----------\n");

                    if (numeropessoas == 0)
                    {
                        Console.WriteLine("A fila está vazia.");
                    }
                    else
                    {
                        Console.WriteLine("Pacientes Preferenciais:");
                        Console.WriteLine("-------------------------");
                        for (int i = 0; i < numeropessoas; i++)
                        {
                            if (fila[i].preferencial.ToLower() == "sim")
                            {
                                fila[i].Exibir(i + 1);
                            }
                        }

                        Console.WriteLine("\nPacientes Comuns:");
                        Console.WriteLine("-------------------------");
                        for (int i = 0; i < numeropessoas; i++)
                        {
                            if (fila[i].preferencial.ToLower() != "sim")
                            {
                                fila[i].Exibir(i + 1);
                            }
                        }
                    }

                    Console.WriteLine("\nPressione qualquer tecla para voltar ao menu...");
                    Console.ReadKey();
                }

                if (opcao == "3")
                {
                    Console.Clear();
                    Console.WriteLine("----------Atendimento----------\n");

                    if (numeropessoas == 0)
                    {
                        Console.WriteLine("Não há pacientes na fila.");
                    }
                    else
                    {
                        Console.WriteLine("Atendendo paciente:");
                        fila[0].Exibir(1);

                        for (int i = 0; i < numeropessoas - 1; i++)
                        {
                            fila[i] = fila[i + 1];
                        }

                        numeropessoas--;
                        Console.WriteLine("\nPaciente atendido e removido da fila.");
                    }

                    Console.WriteLine("\nPressione qualquer tecla para voltar ao menu...");
                    Console.ReadKey();
                }

                if (opcao == "4")
                {
                    Console.Clear();
                    Console.WriteLine("----------Alterar Dados----------\n");

                    if (numeropessoas == 0)
                    {
                        Console.WriteLine("Não há pacientes para alterar.");
                    }
                    else
                    {
                        for (int i = 0; i < numeropessoas; i++)
                        {
                            fila[i].Exibir(i + 1);
                        }

                        Console.Write("\nDigite o número do paciente que deseja alterar: ");
                        int escolha;

                        if (int.TryParse(Console.ReadLine(), out escolha) && escolha > 0 && escolha <= numeropessoas)
                        {
                            fila[escolha - 1].AlterarDados();
                            Console.WriteLine("\nDados alterados com sucesso.");
                        }
                        else
                        {
                            Console.WriteLine("Número inválido.");
                        }
                    }

                    Console.WriteLine("\nPressione qualquer tecla para voltar ao menu...");
                    Console.ReadKey();
                }

                if (opcao == "5" || opcao == "q")
                {
                    opcao = "q";
                    Console.WriteLine("\nSaindo do sistema...");
                    Console.ReadKey();
                }


            }
                }
            }
        }
    
